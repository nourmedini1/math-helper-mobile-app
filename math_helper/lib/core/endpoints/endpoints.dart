// ignore_for_file: constant_identifier_names
class Endpoints {
  Endpoints._();

  static const BASE_URL = "http://10.0.2.2:8000/api/";
  static const API_VERSION = "v1";

//! complex endpoints
  static const ADDITION_ENDPOINT = "$BASE_URL$API_VERSION/complex/addition";
  static const SUBSTRACTION_ENDPOINT =
      "$BASE_URL$API_VERSION/complex/substraction";
  static const MULTIPLICATION_ENDPOINT =
      "$BASE_URL$API_VERSION/complex/multiplication";
  static const POLAR_FORM_ENDPOINT = "$BASE_URL$API_VERSION/complex/polar-form";

//! derivatives endpoints
  static const SYMBOLIC_DERIVATIVE_ENDPOINT =
      "$BASE_URL$API_VERSION/derivatives/symbolic";
  static const NUMERICAL_DERIVATIVE_ENDPOINT =
      "$BASE_URL$API_VERSION/derivatives/numeric";

//! integrals endpoints
  static const SINGLE_PRIMITIVE_ENDPOINT =
      "$BASE_URL$API_VERSION/integrals/single";
  static const DOUBLE_PRIMITIVE_ENDPOINT =
      "$BASE_URL$API_VERSION/integrals/double";
  static const TRIPLE_PRIMITIVE_ENDPOINT =
      "$BASE_URL$API_VERSION/integrals/triple";
  static const SINGLE_INTEGRAL_ENDPOINT =
      "$BASE_URL$API_VERSION/integrals/definite/single";
  static const DOUBLE_INTEGRAL_ENDPOINT =
      "$BASE_URL$API_VERSION/integrals/definite/double";
  static const TRIPLE_INTEGRAL_ENDPOINT =
      "$BASE_URL$API_VERSION/integrals/definite/triple";
}
