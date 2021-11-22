RSpec.describe(Question, type: :model) do
  it { is_expected.to(validate_presence_of(:title)) }
  it { is_expected.to(have_many(:answers)) }

  it 'validates presence of title' do
    expect(described_class.new(body: '123123')).not_to(be_valid)
  end

  it { is_expected.to(validate_presence_of(:body)) }

  it 'validates presence of body' do
    expect(described_class.new(title: '123123')).not_to(be_valid)
  end
end
