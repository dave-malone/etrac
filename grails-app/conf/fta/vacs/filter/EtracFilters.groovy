package fta.vacs.filter

class EtracFilters {

	def userService
	
    def filters = {
        all(controller:'*', action:'*') {
            before = {
				def currentUser = userService.getCurrentUser()
				session.currentUser = currentUser
				
				return true
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
