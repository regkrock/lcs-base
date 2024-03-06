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
			spec package: 'LcsBase'.
			spec package: 'Lcs-SlotDefinitions' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-UnitOfWOrk' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-DomainBase' with: [spec requires: #('LcsBase')].
			spec package: 'Lcs-LegalEntities' with: [spec requires: #('Lcs-DomainBase')].
			spec package: 'Lcs-Geography' with: [spec requires: #('Lcs-DomainBase')].
			spec package: 'Lcs-System' with: [ spec requires: #('Lcs-LegalEntities') ].
			spec package: 'Lcs-SystemTests' with: [spec requires: #('Lcs-System')].  
			spec package: 'Lcs-PrototypeSystem' with: [spec requires: #('Lcs-DomainBase')].  
			spec package: 'Lcs-PrototypeSystemTests' with: [spec requires: #('Lcs-PrototypeSystem')].  
			spec package: 'Lcs-Tests' with: [spec requires: #('Lcs-DomainBase')].  
			spec package: 'Lcs-Tools' with: [ spec requires: #('LcsBase') ].
					]
]
