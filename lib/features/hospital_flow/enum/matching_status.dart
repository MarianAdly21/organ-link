enum MatchingStatus { ready, matched, pending, underReview, notFound }

MatchingStatus mapMatchingStatus(String status) {
  switch (status) {
    case 'جاهز':
      return MatchingStatus.ready;
    case 'انتظار':
      return MatchingStatus.pending;
    case 'تحت المراجعة':
      return MatchingStatus.underReview;
    case 'تمت المطابقة':
      return MatchingStatus.matched;
    case 'لم يتم العثور':
      return MatchingStatus.notFound;
    default:
      return MatchingStatus.pending;
  }
}
