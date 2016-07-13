describe Label, type: :model do
  subject { build(:label, name: "LABEL", colour: "#000000") }
  let(:duplicate) { build(:label, subject.attributes) }
  let(:user) { build(:user) }

  describe "db" do
    context "columns" do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:colour).of_type(:string) }
    end
  end

  describe "attributes" do
    it { is_expected.to have_attributes(name: "LABEL")}
    it { is_expected.to have_attributes(colour: "#000000")}
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:colour) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:colour) }
    it { is_expected.to validate_length_of(:colour).is_equal_to(7) }
    it { is_expected.to allow_value('#000000').for(:colour) }
    it { is_expected.to_not allow_value('#000').for(:colour) }
    it { is_expected.to_not allow_value('000000').for(:colour) }
    it { is_expected.to_not allow_value('0000000').for(:colour) }
    it { is_expected.to_not allow_value('#').for(:colour) }
  end

  describe "associations" do
    context 'users' do
      it { is_expected.to have_and_belong_to_many(:users) }
      # it { is_expected.to have_many(:labels_users) }
      # it { is_expected.to have_many(:users).through(:labels_users) }
      it "shouldn't allow duplicate users" do
        subject.users << user
        subject.users << user
        # is_expected.to_not be_valid
        is_expected.users.to have(1).items
      end
    end
  end

  describe "valid record" do
    it { is_expected.to be_valid }
    it 'different name, same colour' do
      duplicate.name = "LABEL2"
      duplicate.save
      is_expected.to be_valid
    end
    it 'different colour, same name' do
      duplicate.colour = "#eee"
      duplicate.save
      is_expected.to be_valid
    end
  end

  describe "invalid record" do
    context "no name" do
      it do
        subject.name = nil
        is_expected.to_not be_valid
      end
    end
    context "no colour" do
      it do
        subject.colour = nil
        is_expected.to_not be_valid
      end
    end
    context "duplicate name and colour" do
      it do
        duplicate.save
        is_expected.to_not be_valid
      end
    end
  end
end
