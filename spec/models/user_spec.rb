describe User, type: :model do
  subject { build(:user, email: "user@mail.com") }
  let(:label) { build(:label) }

  describe "attributes" do
    it { is_expected.to have_attributes(email: "user@mail.com")}
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe "associations" do
    context 'labels' do
      # it { is_expected.to have_and_belong_to_many(:labels) }
      it { is_expected.to have_many(:user_labels) }
      it { is_expected.to have_many(:labels).through(:user_labels) }
      it "shouldn't allow duplicate labels" do
        subject.labels << label
        subject.labels << label
        is_expected.to_not be_valid
      end
    end
  end
end
