#ifndef JSONIFY_FROM_JSON_API_H
#define JSONIFY_FROM_JSON_API_H

#include <Rcpp.h>
#include "jsonify/from_json/from_json.hpp"

namespace jsonify {
namespace api {

  //' Parse JSON String
  //'
  //' Takes a JSON string as input, returns an R list of key-value pairs
  //'
  //' @param json const char, JSON string to be parsed. Coming from R, this
  //'  input should be a character vector of length 1.
  //' @export
  inline SEXP from_json(rapidjson::Value& doc, bool& simplify, bool& fill_na ) {

    int sequential_array_counter = 0;
    
    // If the input is a scalar value of type int, double, string, or bool, 
    // return Rcpp vector with length 1.
    if( doc.IsInt() ) {
      Rcpp::IntegerVector x(1);
      x[0] = doc.GetInt();
      return x;
    }
    
    if( doc.IsDouble() ) {
      Rcpp::NumericVector x(1);
      x[0] = doc.GetDouble();
      return x;
    }
    
    if( doc.IsString() ) {
      Rcpp::CharacterVector x(1);
      x[0] = Rcpp::String(doc.GetString());
      return x;
    }
    
    if( doc.IsBool() ) {
      Rcpp::LogicalVector x(1);
      x[0] = doc.GetBool();
      return x;
    }
    
    return jsonify::from_json::json_to_sexp( doc, simplify, fill_na, sequential_array_counter );
  }

  inline SEXP from_json( const char* json, bool& simplify, bool& fill_na ) {
    rapidjson::Document doc;
    doc.Parse(json);

    // Make sure there were no parse errors
    if(doc.HasParseError()) {
      Rcpp::stop("json parse error");
    }
    
    return from_json( doc, simplify, fill_na );
  }

}
} // jsonify

#endif