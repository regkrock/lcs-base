Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#instVars : [
		'countries'
	],
	#category : #'Lcs-Geography'
}

{ #category : #'slot definitions' }
LcsGeographyModule class >> countriesSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlotDefinition new
		slotName: 'countries';
		beIdentitySetCollection;
		yourself
]

{ #category : #accessing }
LcsGeographyModule class >> moduleName [
	^'Geography Module'
]

{ #category : #accessing }
LcsGeographyModule >> countries [
	^ countries
]

{ #category : #accessing }
LcsGeographyModule >> countries: anObject [
	countries := anObject
]
