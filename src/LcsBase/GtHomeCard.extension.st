Extension { #name : #GtHomeCard }

{ #category : #'*LcsBase' }
GtHomeCard class >> lcsBaseGetStartedSection [
	<gtHomeSection>
	<gtExample>
	<noTest>	
	^ GtHomeLepiterBaseCard new 
		databaseName: 'regkrock/lcs-base/lepiter';
		yourself

]
