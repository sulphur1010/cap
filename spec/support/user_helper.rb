
def sign_in(user)
	post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
end

