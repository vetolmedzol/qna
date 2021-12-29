require_relative 'shared_examples/decorator'

RSpec.describe(QuestionsController) do
  let(:question) { create(:question, user: @user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array  of all questions' do
      expect(assigns(:questions)).to(match_array(questions))
    end

    it 'renders index view' do
      expect(response).to(render_template(:index))
    end
  end

  describe 'GET #show' do
    let!(:question) { create(:question, user: create(:user)) }

    before { get :show, params: { id: question } }

    include_examples 'decorator'

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to(eq(question))
    end

    it 'render show view' do
      expect(response).to(render_template(:show))
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'assigns a new question to @question' do
      expect(assigns(:question)).to(be_a_new(Question))
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to(be_a_new(Attachment))
    end

    it 'render new view' do
      expect(response).to(render_template(:new))
    end
  end

  describe 'GET #edit' do
    sign_in_user

    before { get :edit, params: { id: question } }

    include_examples 'decorator'

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to(eq(question))
    end

    it 'render edit view' do
      expect(response).to(render_template(:edit))
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new question in database' do
        expect { post(:create, params: { question: attributes_for(:question) }) }.to(change(Question, :count).by(1))
      end

      it 'redirect to show' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to(redirect_to(question_path(assigns(:question))))
      end
    end

    context 'with invalid attributes' do
      it 'does not seve the new question in database' do
        expect { post(:create, params: { question: attributes_for(:invalid_question) }) }.not_to(change(Question, :count))
      end

      it 're-render new  view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to(render_template(:new))
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(assigns(:question)).to(eq(question))
      end

      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        question.reload
        expect(question.title).to(eq('new title'))
        expect(question.body).to(eq('new body'))
      end

      it 'redirect to updated  question' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        expect(response).to(redirect_to(question))
      end
    end

    context 'invalid attributes' do
      before { patch :update, params: { id: question, question: { title: 'new title', body: nil } }, format: :js }

      it 'does  not change question attributes' do
        question.reload
        expect(question.title).to(eq('MyString'))
        expect(question.body).to(eq('MyText'))
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before { question }

    it 'delete question' do
      expect { delete(:destroy, params: { id: question }) }.to(change(Question, :count).by(-1))
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: question }
      expect(response).to(redirect_to(questions_path))
    end
  end
end
