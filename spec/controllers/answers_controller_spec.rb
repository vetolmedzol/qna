require 'rails_helper'

RSpec.describe(AnswersController) do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

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
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:answer) } }

      it 'saves the new question in the database' do
        expect { create_request }.to(change(question.answers, :count).by(1))
      end

      it 'redirects to show view' do
        create_request
        expect(response).to(redirect_to(question_path(assigns(:question))))
      end
    end

    context 'with invalid attributes' do
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }

      it 'doesnt save answer in db' do
        expect { create_request }.not_to(change(Answer, :count))
      end

      it 'redirects to new view' do
        create_request
        expect(response).to(render_template(:new))
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      question
      answer
    end

    it 'delete answer' do
      expect { delete(:destroy, params: { question_id: question, id: answer }) }.to(change(Answer, :count).by(-1))
    end

    it 'redirect to index view' do
      delete(:destroy, params: { question_id: question, id: answer })
      expect(response).to(redirect_to(question_path(question)))
    end
  end
end
