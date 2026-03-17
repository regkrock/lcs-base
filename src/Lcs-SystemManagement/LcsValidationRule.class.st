Class {
	#name : 'LcsValidationRule',
	#superclass : 'LcsBaseRule',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'magritte' }
LcsValidationRule >> conditionBlockDescription [
	<magritteDescription>
	^ super conditionBlockDescription
]

{ #category : 'magritte' }
LcsValidationRule >> descriptionDescription [
	<magritteDescription>
	^ super descriptionDescription
]

{ #category : 'validation' }
LcsValidationRule >> evaluateWith: aValidator [
	(self conditionBlock value: aValidator domainObject) ifFalse: [
		aValidator addErrorDescription: self descriptionDescription in: self ]
]

{ #category : 'magritte' }
LcsValidationRule >> magritteAcceptAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 10;
		label: 'Accept';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons accept;
		action: (GtMagritteAction new
				beInFutureProcess;
				beWithFutureResponse;
				action: [ :aModel :aButton :aMemento :aDescription | aMemento commit ]);
		beEnabledAndChangedAndValidAndInactiveOverallStatus;
		beToolbarAction
]

{ #category : 'magritte' }
LcsValidationRule >> magritteInspectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 30;
		label: 'Inspect Memento';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons inspect;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aButton phlow spawnObject: aMemento ]);
		beToolbarAction
]
