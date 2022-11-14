class DocumentsController < ApplicationController

	def index

		# Guarda el usuario actual para actualizar sus datos
		@usuario = current_user

	end

end