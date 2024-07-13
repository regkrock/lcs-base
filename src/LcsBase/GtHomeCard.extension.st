Extension { #name : #GtHomeCard }

{ #category : #'*LcsBase' }
GtHomeCard class >> lcsLepiterBaseWithTableOfContents [
	^ GtHomeLepiterBaseCard new 
		databaseName: 'regkrock/lcs-base/lepiter';
		yourself
]
