Class {
	#name : #LcsLocalCollectionPatternForm,
	#superclass : #LcsMultislotPatternForm,
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'mode',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsLocalCollectionPatternForm class >> builderClass [
	^ LcsDomainClassAndLocalCollectionClassBuilderJob
]

{ #category : #initialize }
LcsLocalCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass.

]

{ #category : #magritte }
LcsLocalCollectionPatternForm >> targetDomainClassesDescription [
	^ nil
]
