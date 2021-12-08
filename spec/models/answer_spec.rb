RSpec.describe(Answer, type: :model) do
  it { is_expected.to(validate_presence_of(:title)) }
  it { is_expected.to(belong_to(:question)) }
  it { is_expected.to(have_many(:attachments)) }

  it { is_expected.to(accept_nested_attributes_for(:attachments)) }
end
