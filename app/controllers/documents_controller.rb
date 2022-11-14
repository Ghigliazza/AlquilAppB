class DocumentsController < ApplicationController

	def index

		# Guarda el usuario actual para actualizar sus datos
		@usuario = current_user

		@listaUsuarios = User.where(rol: "driver", state: 'submitted')

	end

end