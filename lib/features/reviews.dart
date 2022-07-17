
// not implemented


// // import json
// // from time import sleep

// // from typing import Optional, Tuple, List

// // from google_play_scraper import Sort
// // from google_play_scraper.constants.element import ElementSpecs
// // from google_play_scraper.constants.regex import Regex
// // from google_play_scraper.constants.request import Formats
// // from google_play_scraper.utils.request import post

// // MAX_COUNT_EACH_FETCH = 199

// // class _ContinuationToken:
// //     __slots__ = "token", "lang", "country", "sort", "count", "filter_score_with"

// //     def __init__(self, token, lang, country, sort, count, filter_score_with):
// //         self.token = token
// //         self.lang = lang
// //         self.country = country
// //         self.sort = sort
// //         self.count = count
// //         self.filter_score_with = filter_score_with

// // def _fetch_review_items(
// //     url: str,
// //     app_id: str,
// //     sort: int,
// //     count: int,
// //     filter_score_with: Optional[int],
// //     pagination_token: Optional[str],
// // ):
// //     dom = post(
// //         url,
// //         Formats.Reviews.build_body(
// //             app_id,
// //             sort,
// //             count,
// //             "null" if filter_score_with is None else filter_score_with,
// //             pagination_token,
// //         ),
// //         {"content-type": "application/x-www-form-urlencoded"},
// //     )

// //     match = json.loads(Regex.REVIEWS.findall(dom)[0])

// //     return json.loads(match[0][2])[0], json.loads(match[0][2])[-1][-1]

// // def reviews(
// //     app_id: str,
// //     lang: str = "en",
// //     country: str = "us",
// //     sort: Sort = Sort.NEWEST,
// //     count: int = 100,
// //     filter_score_with: int = None,
// //     continuation_token: _ContinuationToken = None,
// // ) -> Tuple[List[dict], _ContinuationToken]:
// //     if continuation_token is not None:
// //         token = continuation_token.token

// //         if token is None:
// //             return (
// //                 [],
// //                 continuation_token,
// //             )

// //         lang = continuation_token.lang
// //         country = continuation_token.country
// //         sort = continuation_token.sort
// //         count = continuation_token.count
// //         filter_score_with = continuation_token.filter_score_with
// //     else:
// //         token = None

// //     url = Formats.Reviews.build(lang=lang, country=country)

// //     _fetch_count = count

// //     result = []

// //     while True:
// //         if _fetch_count == 0:
// //             break

// //         if _fetch_count > MAX_COUNT_EACH_FETCH:
// //             _fetch_count = MAX_COUNT_EACH_FETCH

// //         try:
// //             review_items, token = _fetch_review_items(
// //                 url, app_id, sort, _fetch_count, filter_score_with, token
// //             )
// //         except (TypeError, IndexError):
// //             token = None
// //             break

// //         for review in review_items:
// //             result.append(
// //                 {
// //                     k: spec.extract_content(review)
// //                     for k, spec in ElementSpecs.Review.items()
// //                 }
// //             )

// //         _fetch_count = count - len(result)

// //         if isinstance(token, list):
// //             token = None
// //             break

// //     return (
// //         result,
// //         _ContinuationToken(token, lang, country, sort, count, filter_score_with),
// //     )

// // def reviews_all(app_id: str, sleep_milliseconds: int = 0, **kwargs) -> list:
// //     kwargs.pop("count", None)
// //     kwargs.pop("continuation_token", None)

// //     continuation_token = None

// //     result = []

// //     while True:
// //         _result, continuation_token = reviews(
// //             app_id,
// //             count=MAX_COUNT_EACH_FETCH,
// //             continuation_token=continuation_token,
// //             **kwargs
// //         )

// //         result += _result

// //         if continuation_token.token is None:
// //             break

// //         if sleep_milliseconds:
// //             sleep(sleep_milliseconds / 1000)

// //     return result

// import 'dart:convert';

// import '../constants/google_play.dart' show Sort;
// import '../constants/element.dart' show ElementSpecs;
// import '../constants/regex.dart' show Regex;
// import '../constants/request.dart' show Formats;
// import '../utils/request.dart' show post;

// int MAX_COUNT_EACH_FETCH = 199;

// class _ContinuationToken {
//   String token;
//   String lang;
//   String country;
//   Sort sort;
//   int count;
//   int filter_score_with;

//   _ContinuationToken(this.token, this.lang, this.country, this.sort, this.count,
//       this.filter_score_with);
// }

// _fetch_review_items(
//   String url,
//   String app_id,
//   int sort,
//   int count, {
//   int? filter_score_with,
//   String? pagination_token,
// }) {
//   String body = Formats.Reviews.build_body(
//     app_id: app_id,
//     sort: sort,
//     count: count,
//     filter_score_with:
//         (filter_score_with == null ? "null" : filter_score_with.toString()),
//   );
//   String dom =
//       post(url, body, {"content-type": "application/x-www-form-urlencoded"});
//   var match = json.decode(Regex.REVIEWS.allMatches(dom).first.group(1)!);
//   var r = json.decode(match[0][2]);
//   var r2 = r[r.length - 1];
//   return [r[0], r[r.length - 1][r2.length - 1]];
// }


// reviews(
//   String app_id, {
//   String lang = "en",
//   String country = "us",
//   int sort = Sort.NEWEST,
//   int count = 100,
//   int? filter_score_with,
//   _ContinuationToken? continuation_token,
// }) {
//   if (continuation_token != null) {
//     String token = continuation_token.token;
//     if (token == null) {
//       return [[], continuation_token];
//     }
//     lang = continuation_token.lang;
//     country = continuation_token.country;
//     sort = continuation_token.sort;
//     count = continuation_token.count;
//     filter_score_with = continuation_token.filter_score_with;
//   } else {
//     token = null;
//   }
//   String url = Formats.Reviews.build(lang: lang, country: country);
//   List<dynamic> result = [];
//   while (true) {
//     if (count == 0) {
//       break;
//     }
//     if (count > MAX_COUNT_EACH_FETCH) {
//       count = MAX_COUNT_EACH_FETCH;
//     }
//     try {
//       List<dynamic> review_items = _fetch_review_items(
//         url,
//         app_id,
//         sort,
//         count,
//         filter_score_with: filter_score_with,
//         pagination_token: token,
//       );
//       result.addAll(review_items[0]);
//       token = review_items[1];
//     } catch (e) {
//       token = null;
//       break;
//     }
//     count -= result.length;
//     if (token == null) {
//       break;
//     }
//   }
//   return [result, _ContinuationToken(token, lang, country, sort, count, filter_score_with)];
// }