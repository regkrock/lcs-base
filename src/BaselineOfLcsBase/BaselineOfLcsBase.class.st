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
			spec package: 'Lcs-GemStoneMocks'.
			spec package: 'LcsBase'  with: [ spec requires: #('Lcs-GemStoneMocks' ) ].
			spec package: 'Lcs-UnitOfWOrk' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-SlotDefinitions' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-SystemManagement' with: [ spec requires: #('LcsBase' 'Lcs-UnitOfWOrk' 'Lcs-SlotDefinitions') ].
			spec package: 'Lcs-DomainBase' with: [spec requires: #('Lcs-SystemManagement')].
			spec package: 'Lcs-LegalEntities' with: [spec requires: #('Lcs-DomainBase')].
			spec package: 'Lcs-Geography' with: [spec requires: #('Lcs-DomainBase')].
			spec package: 'Lcs-System' with: [ spec requires: #('Lcs-LegalEntities' 'Lcs-Geography') ].

			" Systems for experimentation "
			spec package: 'Lcs-PrototypeSystem' with: [spec requires: #('Lcs-DomainBase')].  
			spec package: 'Lcs-BarebonesSystem' with: [spec requires: #('Lcs-DomainBase')].  

			" Tests on main code "			
			spec package: 'Lcs-BaseTests' with: [spec requires: #('LcsBase')].
			spec package: 'Lcs-SystemManagementTests' with: [ spec requires: #('Lcs-SystemManagement' 'Lcs-BaseTests') ].
			spec package: 'Lcs-Tests' with: [spec requires: #('Lcs-DomainBase' 'Lcs-BaseTests')].  
			spec package: 'Lcs-SystemTests' with: [spec requires: #('Lcs-System' 'Lcs-Tests')].  

			" Tests on experimentation systems "			
			spec package: 'Lcs-PrototypeSystemTests' with: [spec requires: #('Lcs-PrototypeSystem' 'Lcs-Tests')].  
			spec package: 'Lcs-BarebonesSystemTests' with: [spec requires: #('Lcs-BarebonesSystem' 'Lcs-Tests')].  

			" Tools "
			spec package: 'Lcs-Tools' with: [ spec requires: #('LcsBase') ].
					]
]
