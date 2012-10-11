# encoding: UTF-8
require 'spec_helper'
describe "cache" do
  context "enabled" do
    before do
      @post_1 = Factory(:posts_revision).post
      @post_2 = Factory(:posts_revision).post
      @post_3 = Factory(:posts_revision).post
      25.times { |i| Factory(:posts_revision, :title => "post #{i}", :url => "post/#{i*100}") }
      @post_with_tag = Factory(:post_with_tags)
      ActionController::Base.perform_caching = true
      Monologue::PageCache.enabled = true
      clear_cache
    end

    after do
      ActionController::Base.perform_caching = false
      clear_cache
    end

    describe "creates" do
      it "post's index cache" do
        assert_create_cache("/monologue", "post 22")
      end

      it "post's show cache" do
        assert_create_cache("/monologue/post/200", "post 2")
      end

      it "feed cache" do
        assert_create_cache(feed_path, "post 22", "rss")
      end

      it "tag cache" do
        assert_create_cache(tags_page_path(@post_with_tag.tags.first.name), @post_with_tag.tags.first.name)
      end
    end

    describe "sweeper" do
      before(:each) do
        @test_paths = ["/monologue","/monologue/#{@post_1.active_revision.url}", "/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]
        @test_paths.each do |path|
          assert_create_cache(path)
        end
        assert_create_cache(feed_path,nil,"rss")
        assert_create_cache(tags_page_path(@post_with_tag.tags.first.name), @post_with_tag.tags.first.name)
        @tags_file_path = "#{Rails.public_path}/monologue/tags"
      end

      it "should clear cache on create" do
        post = Factory(:post)
        cache_sweeped?(["/monologue"]).should be_true
        cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
        cache_sweeped?([feed_path], "rss").should be_true
        File.exists?(@tags_file_path).should be_false
      end

      it "should clear cache on update" do
        @post_1.save!
        cache_sweeped?(["/monologue/#{@post_1.active_revision.url}"]).should be_true
        cache_sweeped?(["/monologue/"]).should be_true
        cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
        cache_sweeped?([feed_path], "rss").should be_true
        File.exists?(@tags_file_path).should be_false
      end

      it "should clear cache on destroy" do
        @post_1.destroy
        cache_sweeped?(["/monologue/"]).should be_true
        cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
        cache_sweeped?([feed_path], "rss").should be_true
        File.exists?(@tags_file_path).should be_false
      end

      it "won't clean cache if saving a not yet published post" do
        @post_1.published = false
        @post_1.save!
        cache_sweeped?(["/monologue/#{@post_1.active_revision.url}"]).should be_false
        cache_sweeped?(["/monologue/"]).should be_false
        cache_sweeped?(["/monologue/#{@post_2.active_revision.url}", "/monologue/#{@post_3.active_revision.url}"]).should be_false
        cache_sweeped?([feed_path], "rss").should be_false
        File.exists?(@tags_file_path).should be_true
      end

    end

    context "admin" do
      it "should display a warning after saving a post published at a future date when cache is ON" do
        ActionController::Base.perform_caching = true
        log_in
        visit new_admin_post_path
        fill_in "Title", :with =>  "my title"
        fill_in "Content", :with =>  "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
        fill_in "Published at", :with =>  DateTime.now + 2.days
        check "Published"
        click_button "Save"
        page.should have_content I18n.t("monologue.admin.posts.create.created_with_future_date_and_cache")
        click_button "Save"
        page.should have_content I18n.t("monologue.admin.posts.update.saved_with_future_date_and_cache")
      end

      it "should NOT display a warning after saving a post published at a future date when cache is OFF" do
        ActionController::Base.perform_caching = false
        log_in
        visit new_admin_post_path
        fill_in "Title", :with =>  "my title"
        fill_in "Content", :with =>  "C'est l'histoire d'un gars comprends tu...and finally it has some french accents àèùöûç...meh!"
        fill_in "Published at", :with =>  DateTime.now + 2.days
        check "Published"
        click_button "Save"
        page.should have_content I18n.t("monologue.admin.posts.create.created")
        click_button "Save"
        page.should have_content I18n.t("monologue.admin.posts.update.saved")
      end
    end
  end # cache enabled

  describe "monologue specific config & behaviors" do
    it "has page_cache configs exists" do
      Monologue::PageCache.enabled = true
      Monologue::PageCache.wipe_enabled = true
      Monologue::PageCache.wipe_after_save = true
    end

    context "ActionController page cache enabled but not Monologue::PageCache.enabled" do
      before do
        clear_cache
        ActionController::Base.perform_caching = true
        Monologue::PageCache.enabled = nil
      end

      it "do not cache pages" do
        post_1 = Factory(:posts_revision).post
        url = "/monologue/#{post_1.active_revision.url}"
        visit url
        url.is_page_cached?.should be_false
      end

      it "do not cache tag pages" do
        post = Factory(:post_with_tags)
        tag_page = "/monologue/tags/rails"
        visit tag_page
        tag_page.is_page_cached?.should be_false
      end
    end

    describe "wipe" do
      before do
        ActionController::Base.perform_caching = true
        Monologue::PageCache.enabled = true
        Monologue::PageCache.wipe_enabled = true
        @post_1 = Factory(:posts_revision).post
        @post_2 = Factory(:posts_revision).post
      end

      context "wipe enabled" do
        before { Monologue::PageCache.wipe_after_save = true }

        context 'cache dir is NOT public dir' do
          before { ActionController::Base.page_cache_directory = Rails.public_path + "/my-cache-dir" }

          it "wipe all cache after save if wipe_after_save is true" do
            Factory(:post_with_tags)
            visit "/monologue/#{@post_1.active_revision.url}"
            visit "/monologue/#{@post_2.active_revision.url}"
            @post_1.save!
            "/monologue/#{@post_1.active_revision.url}.html".is_page_cached?.should be_false
            "/monologue/#{@post_2.active_revision.url}.html".is_page_cached?.should be_false
          end
        end

        context 'cache dir is public dir' do
          before { ActionController::Base.page_cache_directory = Rails.public_path }

          it "do NOT wipe cache if page_cache_directory == Rails.public_path" do
            visit "/monologue/#{@post_1.active_revision.url}"
            visit "/monologue/#{@post_2.active_revision.url}"
            @post_1.save!
            "/monologue/#{@post_1.active_revision.url}.html".is_page_cached?.should be_false
            "/monologue/#{@post_2.active_revision.url}.html".is_page_cached?.should be_true
          end
        end
      end

      context "wipe disabled" do
        before { Monologue::PageCache.wipe_after_save = nil }

        it "do NOT wipe cache if wipe_after_save is not true" do
          visit "/monologue/#{@post_1.active_revision.url}"
          visit "/monologue/#{@post_2.active_revision.url}"
          @post_1.save!
          "/monologue/#{@post_1.active_revision.url}.html".is_page_cached?.should be_false
          "/monologue/#{@post_2.active_revision.url}.html".is_page_cached?.should be_true
        end
      end
    end
=begin
    context "ActionController page cache disabled" do
      it "do not cache pages" do
        ActionController::Base.perform_caching = false
        Monologue::PageCache.enabled = true
        post_1 = Factory(:posts_revision).post
        visit "/monologue/#{post_1.active_revision.url}"
        page.page_cached?
        #page_cached?(["/monologue/#{post_1.active_revision.url}"]).should be_true
      end
    end
=end
  end
end