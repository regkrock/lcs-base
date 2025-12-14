Extension { #name : 'LcsModule' }

{ #category : '*Lcs-Calendar' }
LcsModule >> calendarModule [
	^ self moduleNamed: LcsCalendarModule defaultModuleName
]
