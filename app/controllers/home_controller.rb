class HomeController < ApplicationController
	def index
	end
	def test
		admin = Admin.new
		admin.id = 1
		admin.email = 'sys@admin.com'
		admin.password = 'password'
		admin.username = 'sys'
		admin.save
		render 'index'
	end
	def test2
		@time1 = Time.now
		@time2 = Time.now-4.minutes
		@difference = TimeDifference.between(@time2, @time1).in_minutes
		@test = (TimeDifference.between(@time2, @time1).in_minutes < 30 and @time1 < @time2)
	end
end
