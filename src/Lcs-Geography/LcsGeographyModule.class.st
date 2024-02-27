Class {
	#name : #LcsGeographyModule,
	#superclass : #LcsModule,
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsGeographyModule class >> moduleName [
	^'Geography Module'
]

{ #category : #accessing }
LcsGeographyModule >> countriesSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlotDefinition new
		slotName: 'countries';
		collectionClass: LcsSmalltalkConfiguration identitySetClass
		yourself
]
