Class {
	#name : #BaselineOfLcsBase,
	#superclass : #BaselineOf,
	#category : #BaselineOfLcsBase
}

{ #category : #loading }
BaselineOfLcsBase class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'lcs-base' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfLcsBase >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Lcs-Base'.
			spec package: 'Lcs-System' with: [ spec requires: #('Lcs-Base') ].
			spec package: 'Lcs-DomainBase'with: [ spec requires: #('Lcs-Sysstem') ].
			spec package: 'Lcs-LegalEntities'with: [ spec requires: #('Lcs-DomainBase') ].
			spec package: 'Lcs-SystemTests' with: [ spec requires: #('Lcs-LegalEntities')].
		]
]