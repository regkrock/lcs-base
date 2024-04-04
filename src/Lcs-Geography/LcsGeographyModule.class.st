Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#instVars : [
		'countries'
	],
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsGeographyModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsGeographyModuleConfiguration
]

{ #category : #'slot definitions' }
LcsGeographyModule class >> countriesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlotDefinition new
		slotName: 'countries';
		beIdentitySetCollection;
		yourself
]

{ #category : #configuration }
LcsGeographyModule class >> moduleName [
	^ 'Geography Module'
]

{ #category : #accessing }
LcsGeographyModule >> countries [
	^ countries
]

{ #category : #accessing }
LcsGeographyModule >> countries: anObject [
	countries := anObject
]
