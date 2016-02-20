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
end
