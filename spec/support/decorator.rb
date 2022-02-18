RSpec.shared_examples('decorator') do
  it 'questions in questions controllers should be decorated' do
    expect(assigns(:question)).to(be_decorated_with(QuestionDecorator))
  end
end
