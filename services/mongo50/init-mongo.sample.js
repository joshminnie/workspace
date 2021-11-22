db.createUser(
{
    user: "user-goes-here",
    pwd: "password-goes-here",
    roles: [
        {
            role: "readWrite",
            db: "test"
        }
    ]
}
)
