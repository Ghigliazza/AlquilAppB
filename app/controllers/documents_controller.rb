class DocumentsController < ApplicationController

	

	def index

		# Si el usuario esta admitted, verifica su licencia
		verificar_licencia

		# Guarda el usuario actual para actualizar sus datos
		@usuario = current_user
		@listaUsuarios = User.where(rol: "driver", state: 'submitted')
	end

	def verificar_licencia
    if current_user.driver? && current_user.admitted?
      if current_user.licenseExpiration.present? && current_user.licenseExpiration < Date.today

        #Pasar al usuario al estado :expired (pone la licencia en nil para que no impida hacer un update el 'validates')
        current_user.update(state: 'expired', licenseExpiration: nil);

      end
    end
  end

end