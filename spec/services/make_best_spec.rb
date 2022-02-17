RSpec.describe(MakeBest) do
  subject { described_class.new(not_the_best_answer).call }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:not_the_best_answer) { create(:answer, question: question, best: false) }
  let!(:the_best_answer) { create(:answer, question: question, best: true) }

  it 'change not_the_best_answer best:field to true' do
    expect { subject }.to(change { not_the_best_answer.reload.best }.from(false).to(true))
  end

  it 'change the_best_answer best:field to false' do
    expect { subject }.to(change { the_best_answer.reload.best }.from(true).to(false))
  end
end
