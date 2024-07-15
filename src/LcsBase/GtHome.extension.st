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
	^ LcsHomeMultiCardSection new
]
