Class {
	#name : #BaselineOfLcsBase,
	#superclass : #BaselineOf,
	#category : #BaselineOfLcsBase
}

{ #category : #accessing }
BaselineOfLcsBase class >> manuallyLoadLepiter [
	| repository defaultDatabase currentProperties |
	
	repository := IceRepository registry 
				detect: [ :aRepository | aRepository name = 'lcs-base' ] 
				ifNone: [nil].

	defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
	currentProperties := defaultDatabase properties.
	currentProperties addRegisteredDirectory: repository repositoryDirectory / 'lepiter'.
	defaultDatabase reload.
]

{ #category : #baselines }
BaselineOfLcsBase >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Lcs-GemStoneMocks'.
			spec package: 'LcsBase'  with: [ spec requires: #('Lcs-GemStoneMocks') ].
			spec package: 'Lcs-PharoExtensions' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-SystemManagement' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-SlotDefinitions' with: [ spec requires: #('Lcs-SystemManagement') ].
			spec package: 'Lcs-Tools' with: [ spec requires: #( 'Lcs-SlotDefinitions') ].
			spec package: 'Lcs-DomainBase' with: [ spec requires: #('Lcs-Tools') ].
			spec package: 'Lcs-StateMachine-Core' with: [ spec requires: #('Lcs-DomainBase') ].

			spec package: 'Lcs-Geography' with: [ spec requires: #('Lcs-DomainBase' ) ].
			spec package: 'Lcs-LegalEntities' with: [ spec requires: #('Lcs-DomainBase' 'Lcs-Geography') ].
			spec package: 'Lcs-System' with: [ spec requires: #('Lcs-LegalEntities' 'Lcs-Geography' ) ].

			spec package: 'Lcs-PrototypeSystem' with: [ spec requires: #('Lcs-DomainBase' 'Lcs-StateMachine-Core') ].  

			spec package: 'Lcs-BaseTests' with: [ spec requires: #('LcsBase')  ].
			spec package: 'Lcs-PrototypeSystemTests' with: [ spec requires: #('Lcs-PrototypeSystem' 'Lcs-SystemManagementTests') ].  
			spec package: 'Lcs-SystemManagementTests' with: [ spec requires: #('Lcs-SystemManagement' 'Lcs-BaseTests') ].
			spec package: 'Lcs-SlotDefinitionsTests' with: [ spec requires: #('Lcs-PrototypeSystemTests') ].
			spec package: 'Lcs-StateMachine-Tests' with: [ spec requires: #('Lcs-StateMachine-Core' 'Lcs-PrototypeSystem' 'Lcs-PrototypeSystemTests') ].
			spec package: 'Lcs-SystemTests' with: [ spec requires: #('Lcs-MainSystem' 'Lcs-SlotDefinitionsTests') ].  

			spec package: 'Lcs-WarRabbitLibrary' with: [ spec requires: #('Lcs-LegalEntities') ].
			spec package: 'Lcs-WarRabbitLibraryTests' with: [ spec requires: #('Lcs-WarRabbitLibrary' 'Lcs-SystemManagementTests') ].  

			spec package: 'Lcs-Examples' with: [ spec requires: #('Lcs-DomainBase') ].
			
			spec package: 'Lcs-Css' with: [ spec requires: #('LcsBase') ].
			spec package: 'Lcs-CssTests' with: [ spec requires: #('Lcs-BaseTests' 'Lcs-Css') ].

			spec package: 'Lcs-WebComponents' with: [ spec requires: #('Lcs-DomainBase') ].
			spec package: 'Lcs-WebComponentsTests' with: [ spec requires: #('Lcs-WebComponents' 'Lcs-SystemManagementTests' 'Lcs-PrototypeSystem' ) ]
				]
]
