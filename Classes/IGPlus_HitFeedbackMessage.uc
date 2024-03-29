class IGPlus_HitFeedbackMessage extends LocalMessage;

static function ClientReceive(
	PlayerPawn P,
	optional int Sw,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
) {
	local ClientSettings Settings;
	local bool bInstigator;
	local bool bViewTarget;

	if (RelatedPRI_1 == none || RelatedPRI_2 == none)
		return;

	if (P.IsA('bbPlayer'))
		Settings = bbPlayer(P).Settings;
	else if (P.IsA('bbCHSpectator'))
		Settings = bbCHSpectator(P).Settings;

	bInstigator = RelatedPRI_2.Owner == P;
	bViewTarget = RelatedPRI_2.Owner == P.ViewTarget;

	if ((bInstigator || bViewTarget) == false)
		return;

	if (Settings.HitMarkerSource == HMSRC_Server || bViewTarget)
		class'bbPlayerStatics'.static.PlayHitMarker(P, Settings, Abs(Sw), RelatedPRI_2.Team, RelatedPRI_1.Team);

	if (Settings.HitSoundSource == HSSRC_Server || bViewTarget)
		class'bbPlayerStatics'.static.PlayHitSound(P, Settings, Abs(Sw), RelatedPRI_2.Team, RelatedPRI_1.Team);
}

