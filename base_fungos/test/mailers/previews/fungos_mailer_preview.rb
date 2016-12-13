# Preview all emails at http://localhost:3000/rails/mailers/fungos_mailer
class FungosMailerPreview < ActionMailer::Preview
	def teste
		FungosMailer.email_teste()
	end
end
