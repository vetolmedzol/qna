RSpec.describe(AnswersController) do
  sign_in_user
  let!(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, question: question) }
  let(:my_answer) { create(:answer, question: question, user: @user) }

  describe 'GET #show' do
    before { get :show, params: { question_id: question, id: answer } }

    it 'assigns the requested question to @answer' do
      expect(assigns(:question)).to(eq(question))
    end

    it 'render show view' do
      expect(response).to(render_template(:show))
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question }, xhr: true }

    it 'assigns new answer to question' do
      expect(assigns(:answer)).to(be_a_new(Answer))
    end

    it 'no redirects' do
      expect(response).not_to(have_http_status(:redirect))
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:answer) }, xhr: true }

      it 'saves the new answer in the database' do
        expect { create_request }.to(change(question.answers, :count).by(1))
      end

      it 'not redirects anywhere after create' do
        create_request
        expect(response).not_to(have_http_status(:redirect))
      end
    end

    context 'with invalid attributes' do
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }, xhr: true }

      it 'doesnt save answer in db' do
        expect { create_request }.not_to(change(Answer, :count))
        expect { create_request }.not_to(change(Answer, :count))
      end

      it 'not redirects anywhere' do
        create_request
        expect(response).not_to(have_http_status(:redirect))
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      question
      answer
      my_answer
    end

    it 'delete my answer' do
      expect { delete(:destroy, params: { question_id: question, id: my_answer }, xhr: true) }.to(change(question.answers, :count).by(-1))
    end

    it 'not redirects anywhere after delete' do
      delete(:destroy, params: { question_id: question, id: my_answer }, xhr: true)
      expect(response).not_to(have_http_status(:redirect))
    end

    it 'delete foreign answer' do
      expect { delete(:destroy, params: { id: answer, question_id: question }, xhr: true) }.not_to(change(question.answers, :count))
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:answer) { create(:answer, question: question, user: @user) }

    it 'assigns the requested answer to @answer' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:answer)).to(eq(answer))
    end

    it 'assigns the requested question to @question' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:question)).to(eq(question))
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, question_id: question, answer: { title: 'new title' } }, format: :js
      answer.reload
      expect(answer.title).to(eq('new title'))
    end

    it 'render update template' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(response).to(render_template(:update))
    end
  end

  describe '#PATCH make_best' do
    let!(:answer) { create(:answer, question: question) }
    let!(:best_answer) { create(:answer, question: question, best: true) }

    before { patch :make_best, params: { id: answer, question_id: question, answer: { best: true }, format: :js } }

    it 'change best answer' do
      answer.reload
      best_answer.reload
      expect(answer.best).to(eq(true))
      expect(best_answer.best).to(eq(false))
    end

    it 'render template make_best' do
      expect(response).to(render_template(:make_best))
    end
  end
end
