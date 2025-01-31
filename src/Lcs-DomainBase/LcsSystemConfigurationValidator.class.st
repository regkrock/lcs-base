Class {
	#name : #LcsSystemConfigurationValidator,
	#superclass : #LcsValidator,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'gt view' }
LcsSystemConfigurationValidator >> gtConfigurationIssuesFor: aView [
	<gtView>
	self hasNoValidationIssues ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Attributes';
		priority: 10;
		items: [ self validationIssues ];
		column: 'Context'
			text: #context
			width: 200;
		column: 'Message'
			text: #message;
		send: #value;
		yourself
]

{ #category : #validation }
LcsSystemConfigurationValidator >> validateCurrentObject [
	self objectBeingValidated addValidateConfigurationResultTo: self
]
