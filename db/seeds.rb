User.create!(name: "Example User",
    email: "examples@railstutorial.org",
    password: "foobar",
    account_name: "admins",
    password_confirmation: "foobar",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)
