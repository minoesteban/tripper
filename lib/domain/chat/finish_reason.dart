enum FinishReason { unspecified, stop, maxTokens, safety, recitation, other, unhandled }

FinishReason getFinishReasonFromCode(String? code) {
  switch (code) {
    case 'FINISH_REASON_UNSPECIFIED':
      return FinishReason.unspecified;
    case 'STOP':
      return FinishReason.stop;
    case 'MAX_TOKENS':
      return FinishReason.maxTokens;
    case 'SAFETY':
      return FinishReason.safety;
    case 'RECITATION':
      return FinishReason.recitation;
    case 'OTHER':
      return FinishReason.other;
    default:
      return FinishReason.unhandled;
  }
}
