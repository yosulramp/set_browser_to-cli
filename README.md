# set_brwoser_to-cli

Set default browser you want.

## Usage
In root of source code:
`swift build --configuration release`

Copy compiled binary to a directory that is in the your $PATH:
`cp -f .build/release/sbt /usr/local/bin/sbt`

Run like:
`sbt --help`
`sbt <the_browser_name_you_want_to_change>`

Then show confirm box, you choose whether it will change or not.