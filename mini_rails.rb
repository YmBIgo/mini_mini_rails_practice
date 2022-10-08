# https://github.com/saullbrandao/mini_mvc の 写経コード

require "mini_rails/version"
require "mini_rails/routing"
require "mini_rails/util"
require "mini_rails/dependencies"
require "mini_rails/controller"
require "mini_rails/file_model"

module MiniRails
	class Error < StandardError; end

	class Application
		def call(env)
			if env['PATH_INFO'] == '/favicon.icon'
				return [404, {'Content-Type' => 'text/html'}, []]
			end

			klass, act = get_controller_and_action(env)
			controller = klass.new(env)
			text = controller.send(act)
			[200, {"Content-Type" => "text/plain"}, [text]]
		end
	end
end