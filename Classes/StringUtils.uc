class StringUtils extends Object;

static function string PackageOfClass(class C) {
	local string Result;
	local int DotPos;

	Result = string(C);

	DotPos = InStr(Result, ".");
	if (DotPos < 0) return "";

	return Left(Result, DotPos);
}

static function string PackageOfObject(Object O) {
	return PackageOfClass(O.Class);
}

static function string GetPackage() {
	return PackageOfClass(class'StringUtils');
}

static function string RepeatString(int Length, string S) {
	local string result;

	if (Length <= 0 || Len(S) == 0) return "";

	while (Length > 0) {
		if ((Length & 1) == 1)
			result = result $ S;

		Length = Length >> 1;
		S = S $ S;
	}

	return result;
}

static function string RepeatChar(int Length, int Char) {
	if (Char == 0) return "";
	return RepeatString(Length, Chr(Char));
}

static function string CenteredString(coerce string Content, int Length, optional string Fill) {
	local string Dummy;

	if (Len(Fill) == 0) Fill = " ";

	if (Length <= Len(Content))
		return Content;

	Dummy = RepeatString((Length + 1 - Len(Content)) >> 1, Left(Fill, 1));

	return Left(Dummy, (Length - Len(Content)) >> 1) $ Content $ Left(Dummy, (Length + 1 - Len(Content)) >> 1);
}

static function string Trim(string source)
{
	local int index;
	local string result;

	// Remove leading spaces.
	result = source;
	while (index < len(result) && mid(result, index, 1) == " ")
        {
		index++;
	}
	result = mid(result, index);

	// Remove trailing spaces.
	index = len(result) - 1;
	while (index >= 0 && mid(result, index, 1) == " ")
        {
		index--;
	}
	result = left(result, index + 1);

	// Return new string.
	return result;
}

static function string FormatFloat(float F, optional int Decimals) {
	local string Result;
	local int T;
	if (Decimals <= 0) return string(int(F));
	Result = int(F) $ ".";
	F -= int(F);
	while(Decimals > 0) {
		F *= 10;
		T = int(F);
		Result = Result $ T;
		F -= T;
		Decimals--;
	}
	return Result;
}

static function string CommonPrefix(string A, string B) {
	local int Common;
	local int Length;

	Length = Min(Len(A), Len(B));

	for (Common = 0; Common < Length; ++Common)
		if (Mid(A, Common, 1) != Mid(B, Common, 1))
			break;

	return Left(A, Common);
}

static function string CommonSuffix(string A, string B) {
	local int Common;
	local int Length;

	Length = Min(Len(A), Len(B));

	for (Common = 0; Common < Length; ++Common)
		if (Mid(A, Len(A)-Common-1, 1) != Mid(B, Len(B)-Common-1, 1))
			break;

	return Right(A, Common);
}

static function string MergeAffixes(string Prefix, string Suffix) {
	if (Prefix == Suffix)
		return Prefix;

	return Prefix$Suffix;
}
