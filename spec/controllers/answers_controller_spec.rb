RSpec.describe(AnswersController) do
  sign_in_user
  let(:question) { create(:question) }
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
    before { get :new, params: { question_id: question } }

    it 'assigns new answer to question' do
      expect(assigns(:answer)).to(be_a_new(Answer))
    end

    it 'render new view' do
      expect(response).to(render_template(:new))
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:answer) }, xhr: true }

      it 'saves the new answer in the database' do
        expect { create_request }.to(change(question.answers, :count).by(1))
      end

      it 'not redirects anywhere' do
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
      expect { delete(:destroy, params: { question_id: question, id: my_answer }) }.to(change(question.answers, :count).by(-1))
    end

    it 'redirect to index view' do
      delete(:destroy, params: { question_id: question, id: my_answer })
      expect(response).to(redirect_to(question_path(question)))
    end

    it 'delete foreign answer' do
      expect { delete(:destroy, params: { id: answer, question_id: question }) }.not_to(change(question.answers, :count))
    end
  end
end
