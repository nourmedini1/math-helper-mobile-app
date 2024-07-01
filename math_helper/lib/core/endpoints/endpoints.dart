// ignore_for_file: constant_identifier_names
class Endpoints {
  Endpoints._();

  static const BASE_URL = "http://10.0.2.2:8000/api/";
  static const PUBLIC_BASE_URL = "https://math-helper-api-v1.onrender.com";
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

//! differential equations endpoints
  static const FIRST_ORDER_DIFFERENTIAL_EQUATION_ENDPOINT =
      "$BASE_URL$API_VERSION/differential-equations/first";
  static const SECOND_ORDER_DIFFERENTIAL_EQUATION_ENDPOINT =
      "$BASE_URL$API_VERSION/differential-equations/second";
  static const THIRD_ORDER_DIFFERENTIAL_EQUATION_ENDPOINT =
      "$BASE_URL$API_VERSION/differential-equations/third";

//! limits endpoints
  static const SINGLE_LIMIT_ENDPOINT = "$BASE_URL$API_VERSION/limits/single";
  static const DOUBLE_LIMIT_ENDPOINT = "$BASE_URL$API_VERSION/limits/double";
  static const TRIPLE_LIMIT_ENDPOINT = "$BASE_URL$API_VERSION/limits/triple";

//! product endpoints
  static const SYMBOLIC_PRODUCT_ENDPOINT =
      "$BASE_URL$API_VERSION/product/symbolic";
  static const NUMERICAL_PRODUCT_ENDPOINT =
      "$BASE_URL$API_VERSION/product/numeric";

//! sum endpoints
  static const SYMBOLIC_SUM_ENDPOINT = "$BASE_URL$API_VERSION/sum/symbolic";
  static const NUMERICAL_SUM_ENDPOINT = "$BASE_URL$API_VERSION/sum/numeric";

//! taylor series endpoints
  static const TAYLOR_SERIES_EXPANSION_ENDPOINT =
      "$BASE_URL$API_VERSION/taylor-series/expand";

//! linear systems endpoints
  static const LINEAR_SYSTEMS_ENDPOINT =
      "$BASE_URL$API_VERSION/linear-systems/solve";
}
