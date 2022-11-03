using Dates

header = """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style/normalize.css">
    <link rel="stylesheet" href="style/skeleton.css">
    <link rel="stylesheet" href="style/style.css">
    <base href="/oshd_log/">
    <title>OSHD</title>
</head>

<body>
    <div class="container">
        <h1>OSHD</h1>
"""

footer = """
        </div>
    </body>
</html>
"""

function log_html(log_file, title, html_file)

    html = header
    html = html * """<a href="#" class="button button-primary">Home</a>"""
    html = html * "<h2>" * title * "</h2>"
    for line in Iterators.reverse(eachline(log_file))
        if contains(lowercase(line), "error")
            html = html * "<p class=\"error\">" * line * "</p>"
        else
            html = html * "<p class=\"info\">" * line * "</p>"
        end
    end
    html = html * footer

    file = open(html_file, "w")
    write(file, html)
    close(file)

end


function index_html()

    datestr = Dates.format(now(),"e d u HH:MM")

    html = header
    html = html * """
    <p>
        Webpage last updated: $(datestr)
    </p>
    <p>
        <a href="log_srv1.html" class="button button-primary">Log file server 1</a>
    </p>
    <p>
        <a href="log_srv2.html" class="button button-primary">Log file server 2</a>
    </p>
    """
    html = html * footer

    file = open("index.html", "w")
    write(file, html)
    close(file)

end


function update_page()

    index_html()

    log_html("K:/OSHD_SCHEDULER/oshd_scheduler_srv1.log", "Log file on srv 1", "log_srv1.html")

    log_html("U:/OSHD_SCHEDULER/oshd_scheduler_srv2.log", "Log file on srv 2", "log_srv2.html")

    msg = "page updated " * Dates.format(now(),"yyyy-mm-dd HH:MM")

    run(`git add .`)

    run(`git commit -m $msg`)

    run(`git push`)

end


update_page()
