Class {
	#name : 'LcsMemberOfSlotSourceCollectionNotInitialized',
	#superclass : 'LcsSlotModelError',
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsMemberOfSlotSourceCollectionNotInitialized class >> signalWithContext: aSlotDefinition [
	self new signalWithContext: aSlotDefinition
]

{ #category : 'gt - views' }
LcsMemberOfSlotSourceCollectionNotInitialized >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain Class';
		priority: 6;
		object: [ self context parent parent ];
		view: #gtMetaFor:
]

{ #category : 'gt - views' }
LcsMemberOfSlotSourceCollectionNotInitialized >> gtModuleViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Collection Source Module';
		priority: 5;
		object: [ self context collectionModule ];
		view: #gtRawFor:
]

{ #category : 'gt - views' }
LcsMemberOfSlotSourceCollectionNotInitialized >> gtSlotClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Class';
		priority: 8;
		object: [ self context ];
		view: #gtMetaFor:
]

{ #category : 'gt - views' }
LcsMemberOfSlotSourceCollectionNotInitialized >> gtSlotViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Definition';
		priority: 2;
		object: [ self context ];
		view: #gtRawFor:
]

{ #category : 'signal' }
LcsMemberOfSlotSourceCollectionNotInitialized >> signalWithContext: aSlotDefinition [ 
	self 
		context: aSlotDefinition;
		messageText: self unintializeSourceCollectionMessage;
		signal
]

{ #category : 'message' }
LcsMemberOfSlotSourceCollectionNotInitialized >> unintializeSourceCollectionMessage [
	^'Timing Error - Source collection in module: ''<1s>'', slot: ''<2s>'' not initialized but is needed to initialize <3s> slot' 
		expandMacrosWith: self context collectionSlotModuleName 
		with: self context collectionSlotName
		with: self context slotName
]
