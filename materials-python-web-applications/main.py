from flask import Flask, request
import logging

app = Flask(__name__)

logging.basicConfig(filename="record.log", level=logging.DEBUG)

def fahrenheit_from(celsius):
    """Convert Celsius to Fahrenheit degrees."""
    try:
        fahrenheit = float(celsius) * 9 / 5 + 32
        fahrenheit = round(fahrenheit, 3)  # Round to three decimal places
        return str(fahrenheit)
    except ValueError:
        return "invalid input"


@app.route("/")
def index():
    celsius = request.args.get("celsius", "")
    if celsius:
        fahrenheit = fahrenheit_from(celsius)
    else:
        fahrenheit = ""
    return (
        """<form action="" method="get">
                Celsius temperature: <input type="text" name="celsius">
                <input type="submit" value="Convert to Fahrenheit">
            </form>"""
        + "Fahrenheit: "
        + fahrenheit
    )
app.logger.debug("debug log info")
app.logger.info("Info log information")
app.logger.warning("Warning log info")
app.logger.error("Error log info")
app.logger.critical("Critical log info")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)


