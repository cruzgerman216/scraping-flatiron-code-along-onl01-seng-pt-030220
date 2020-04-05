require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
     doc = Nokogiri::HTML(open("https://www.google.com/search?q=Could+not+find+a+valid+gem+%27nokogiri&rlz=1C1NDCM_enUS758US758&oq=Could+not+find+a+valid+gem+%27nokogiri&aqs=chrome..69i57j0l3.1046j0j7&sourceid=chrome&ie=UTF-8"))
     puts docs
   end

   def get_courses
     self.get_page.css(".post")
  end
  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
end
Scraper.new.get_page
