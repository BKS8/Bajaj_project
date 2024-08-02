from flask import Flask, request, jsonify
import json

app = Flask(__name__)

USER_ID = "john_doe_17091999"
EMAIL = "john@xyz.com"
ROLL_NUMBER = "ABCD123"

@app.route('/bfhl', methods=['POST'])
def process_data():
    try:
        data = request.get_json()

        if not data or 'data' not in data:
            return jsonify({"is_success": False, "error": "Invalid input"}), 400

        input_data = data['data']
        numbers = []
        alphabets = []

        for item in input_data:
            if item.isdigit():
                numbers.append(item)
            elif len(item) == 1 and item.isalpha():
                alphabets.append(item)

        highest_alphabet = []
        if alphabets:
            highest_char = max(alphabets, key=lambda x: x.upper())
            highest_alphabet.append(highest_char)

        response = {
            "is_success": True,
            "user_id": USER_ID,
            "email": EMAIL,
            "roll_number": ROLL_NUMBER,
            "numbers": numbers,
            "alphabets": alphabets,
            "highest_alphabet": highest_alphabet
        }

        return jsonify(response), 200

    except Exception as e:
        return jsonify({"is_success": False, "error": str(e)}), 500


@app.route('/bfhl', methods=['GET'])
def get_operation_code():
    response = {
        "operation_code": 1
    }
    return jsonify(response), 200


if __name__ == '__main__':
    app.run(debug=True)

