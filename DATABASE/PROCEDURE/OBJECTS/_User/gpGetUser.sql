/*
  ��������� ������� ������ ������� <������������>
*/


   /* ���� ���� ����� ��������� - ������� �� */
   IF object_id('gpGetUser') IS NOT NULL 
     DROP PROCEDURE gpGetUser
   GO


/*-------------------------------------------------------------------------------*/

CREATE PROCEDURE gpGetUser

@inId                          Integer   ,         /* ���� ������� <������������> */
@ioListProcedure               TNVarChar OUTPUT,   /* ���� ��������       */
@ioListErrorCode               TNVarChar OUTPUT,   /* ���� ����� ������   */
@inSession                     TVarChar            /* ������      */

/*  ������������ �����

    Id                            ���� ������� <������������>
    Code                          ������� ��� ������� <������������>
    Name                          ������� �������� ������� <������������>
    Login                         �������� <����� ������������>
    Password                      �������� <������ ������������>
    UserGroupId                   ���� ������� <������ �������������>
    UserGroupCode                 ������� ��� ������� <������ �������������>
    UserGroupName                 ������� �������� ������� <������ �������������>
    isErased                      ������� �������� ��� ������� <������������>

*/

/*-------------------------------------------------------------------------------*/

AS
BEGIN

  DECLARE @OperUserId            integer     /* ������������ ���������� �������� */
  DECLARE @CurrentOperationCode  TVarChar    /* ��� ������� �������� */
  DECLARE @SysErrorCode   Integer     /* ��� ��������� ������ */
  DECLARE @SysRowCount    Integer     /* ��� ��������� ������ */
  DECLARE @_UserErrorCode Integer     /* ��� ������ */
  DECLARE @_Code          TVarChar    /* ��� �����. �������������� */
  DECLARE @_procName      TVarChar    /* �������� ������� ��������� ��� ������� ��� ����������� ����� ������� ��� ������ */
      SET @_procName='gpGetUser'

  DECLARE @zc_ObjectUser Integer SET @zc_ObjectUser =  dbo.lfGetObjectDescIdFromCode(dbo.zc_ObjectUser())

  DECLARE @zc_ObjectStringUserLogin Integer SET @zc_ObjectStringUserLogin = dbo.lfGetObjectStringDescIdFromCode(dbo.zc_ObjectStringUserLogin())
  DECLARE @zc_ObjectStringUserPassword Integer SET @zc_ObjectStringUserPassword = dbo.lfGetObjectStringDescIdFromCode(dbo.zc_ObjectStringUserPassword())
  DECLARE @zc_ObjectUser_LinkUserGroup Integer SET @zc_ObjectUser_LinkUserGroup = dbo.lfGetObjectLinkDescIdFromCode(dbo.zc_ObjectUser_LinkUserGroup())


      /* �������� ������ � ����������� ���� ������������ �� ����� ������� ��������� */
      /*  */
      EXECUTE lpCheckUserRights  @OperUserId OUTPUT,  @inSession , @CurrentOperationCode ,@ioListProcedure OUTPUT, @ioListErrorCode OUTPUT

      SET @SysErrorCode=@@ERROR 
      /* �������� ������ */ 
      IF @SysErrorCode<>0 OR ISNULL(@ioListErrorCode, '') <> '' BEGIN 
        SET @_UserErrorCode=dbo.zc_msgNotRightsForGetUser() 
        EXECUTE lpAddErrorStack @ioListProcedure OUTPUT, @ioListErrorCode OUTPUT ,@_ProcName ,@_UserErrorCode, @SysErrorCode 
        RETURN /* !!! ����� ��� ������ !!! */
      END

  SELECT
     Object.Id
   , Object.ObjectCode AS Code
   , Object.ValueData AS Name

   , ObjectStringUserLogin.ValueData AS Login
   , ObjectStringUserPassword.ValueData AS Password
   , ObjectUser_LinkUserGroup.Id AS UserGroupId
   , ObjectUser_LinkUserGroup.ObjectCode AS UserGroupCode
   , ObjectUser_LinkUserGroup.ValueData AS UserGroupName
   , Object.isErased
   FROM Object

  LEFT JOIN ObjectString AS ObjectStringUserLogin ON ObjectStringUserLogin.DescId = @zc_ObjectStringUserLogin AND ObjectStringUserLogin.ObjectId = Object.Id
  LEFT JOIN ObjectString AS ObjectStringUserPassword ON ObjectStringUserPassword.DescId = @zc_ObjectStringUserPassword AND ObjectStringUserPassword.ObjectId = Object.Id
  LEFT JOIN ObjectLink AS ObjectLink_User_LinkUserGroup ON ObjectLink_User_LinkUserGroup.ParentObjectId = Object.Id AND ObjectLink_User_LinkUserGroup.DescId = @zc_ObjectUser_LinkUserGroup
  LEFT JOIN Object AS ObjectUser_LinkUserGroup ON ObjectUser_LinkUserGroup.Id = ObjectLink_User_LinkUserGroup.ChildObjectId
  WHERE Object.DescId = @zc_ObjectUser AND Object.Id = @inId

END
GO

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
23.10.02 11:03 
*/
