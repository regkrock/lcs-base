Extension { #name : #GtHome }

{ #category : #'*LcsBase' }
GtHome >> getStartedSection [
	<gtHomeSection>
	<gtExample>
	<noTest>
	^ GtHomeMultiCardGetStartedSection new

]

{ #category : #'*LcsBase' }
GtHome >> lcsBaseGetStartedSection [
	<gtHomeSection>
	<gtExample>
	<noTest>	
	^ GtHomeLepiterBaseCard new 
		databaseName: 'regkrock/lcs-base/lepiter';
		yourself


]
