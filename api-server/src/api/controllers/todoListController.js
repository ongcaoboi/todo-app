module.exports = {
    get: (req, res) => {
        res.send("todo get");
    },
    store: (req, res) => {
        res.send("todo store");
    },
    detail: (req, res) => {
        res.send("todo detail");
    },
    update: (req, res) => {
        res.send("todo update");
    },
    delete: (req, res) => {
        res.send("todo delete");
    },
}