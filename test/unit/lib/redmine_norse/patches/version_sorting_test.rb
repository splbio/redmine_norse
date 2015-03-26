require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineNorse::Patches::VersionSortingTest < Redmine::IntegrationTest
  fixtures :projects, :versions

  should "#<=> should sort only by id" do
    Version.delete_all
    v1 = Version.create!(:project_id => 1, :name => 'E')
    v2 = Version.create!(:project_id => 1, :name => 'D', :effective_date => '2012-07-14')
    v3 = Version.create!(:project_id => 1, :name => 'C')
    v4 = Version.create!(:project_id => 1, :name => 'B', :effective_date => '2012-08-02')
    v5 = Version.create!(:project_id => 1, :name => 'A', :effective_date => '2012-07-02')

    assert_equal [v1, v2, v3, v4, v5], [v1, v2, v3, v4, v5].sort
  end

  should "#sorted scope should sort only by id" do
    Version.delete_all
    v1 = Version.create!(:project_id => 1, :name => 'E')
    v2 = Version.create!(:project_id => 1, :name => 'D', :effective_date => '2012-07-14')
    v3 = Version.create!(:project_id => 1, :name => 'C')
    v4 = Version.create!(:project_id => 1, :name => 'B', :effective_date => '2012-08-02')
    v5 = Version.create!(:project_id => 1, :name => 'A', :effective_date => '2012-07-02')

    assert_equal [v1, v2, v3, v4, v5], Version.sorted.to_a
  end

end
