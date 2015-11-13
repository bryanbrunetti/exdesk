defmodule ExDeskTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExDesk.configure(site_name: "test.desk.com", email: "email@domain.com", password: "mypasswordshh")
    :ok
  end

  test "Authenticating and accessing cases via HTTP Basic" do
    use_cassette "basic_auth" do
      cases = ExDesk.list("cases", [per_page: 1, fields: "subject"])
      assert cases !== %{"message" => "Invalid Credentials"}
    end
  end

  test "Creating a label" do
    use_cassette "label_creation" do
      label = ExDesk.create("labels", [name: "A Label", description: "a description", types: ["case"], enabled: true, color: "purple"])
      assert label != %{"message" => "Resource Not Found"}
      assert label["name"] == "A Label"
    end
  end

  test "Showing a label" do
    use_cassette "label_show" do
      label = ExDesk.show("cases/686")
      assert label["id"] == 686
    end
  end

  test "Searching/Listing labels" do
    use_cassette "label_search" do
      labels = ExDesk.list("labels/search", [name: "A Label"])
      assert (labels["_embedded"]["entries"] |> List.first)["name"] == "A Label"
    end
  end

  test "Updating a label" do
    use_cassette "label_update_1" do
      label = ExDesk.update("labels/2816853", [color: "red"])
      assert label["color"] == "red"
    end
    use_cassette "label_update_2" do
      label = ExDesk.update("labels/2816853", [color: "purple"])
      assert label["color"] == "purple"
    end
  end

  test "Deleting a label" do
    use_cassette "label_deletion" do
      result = ExDesk.delete("labels/2816817")
      assert result != nil
      assert result == {:ok}
    end
  end

end
