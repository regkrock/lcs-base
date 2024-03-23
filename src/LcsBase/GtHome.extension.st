Extension { #name : #GtHome }

{ #category : #'*LcsBase' }
GtHome >> gtLcsSection [
	<gtHomeSection>
	^ GtHomeStartPageSection new
		title: 'Lcs Book';
		description: 'Documentation of Lcs';
		databaseName: 'regkrock/lcs-base/lepiter';
		startPageName: 'Lcs Table of Contents';
		priority: 8
]
